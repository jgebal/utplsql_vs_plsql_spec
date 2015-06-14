CREATE OR REPLACE PACKAGE BODY utoutputreporter
IS
   
/************************************************************************
GNU General Public License for utPLSQL

Copyright (C) 2000-2003 
Steven Feuerstein and the utPLSQL Project
(steven@stevenfeuerstein.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (see license.txt); if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
************************************************************************
$Log$
Revision 1.1  2004/07/14 17:01:57  chrisrimmer
Added first version of pluggable reporter packages
 

************************************************************************/

   norows BOOLEAN;

   PROCEDURE open
   IS
   BEGIN
     NULL;
   END;

   PROCEDURE close
   IS
   BEGIN
     NULL;
   END;   
   
   -- This is an interface to dbms_output.put_line that tries to
   -- sensibly split long lines (which is useful if you want to 
   -- print large dynamic sql statements). From Alistair Bayley
   PROCEDURE show (
      s                VARCHAR2,
      maxlinelenparm   NUMBER := 255,
      expand           BOOLEAN := TRUE
   )
   IS
      output_buffer_overflow   EXCEPTION;
      PRAGMA EXCEPTION_INIT (output_buffer_overflow, -20000);
      i                        NUMBER;
      maxlinelen               NUMBER
                                    := GREATEST (1, LEAST (255, maxlinelenparm));
   
      FUNCTION locatenewline (str VARCHAR2)
         RETURN NUMBER
      IS
         i10   NUMBER;
         i13   NUMBER;
      BEGIN
         i13 := NVL (INSTR (SUBSTR (str, 1, maxlinelen), CHR (13)), 0);
         i10 := NVL (INSTR (SUBSTR (str, 1, maxlinelen), CHR (10)), 0);
   
         IF i13 = 0
         THEN
            RETURN i10;
         ELSIF i10 = 0
         THEN
            RETURN i13;
         ELSE
            RETURN LEAST (i13, i10);
         END IF;
      END;
   BEGIN
      -- 2.1.2 if NULL, abort.
      IF s IS NULL
      THEN
         DBMS_OUTPUT.put_line (s);
         -- 2.1.2 PBA we should return here...
         RETURN;		 
      -- Simple case: s is short.
      ELSIF LENGTH (s) <= maxlinelen
      THEN
         DBMS_OUTPUT.put_line (s);
         RETURN;
      END IF;
   
      -- OK, so it's long. Look for newline chars as a good place to split.
      i := locatenewline (s);
   
      IF i > 0
      THEN -- cool, we can split at a newline
         DBMS_OUTPUT.put_line (SUBSTR (s, 1, i - 1));
         show (SUBSTR (s, i + 1), maxlinelen, expand);
      ELSE
         -- No newlines. Look for a convenient space prior to the 255-char limit.
         -- Search backwards from maxLineLen.
         i := NVL (INSTR (SUBSTR (s, 1, maxlinelen), ' ', -1), 0);
   
         IF i > 0
         THEN
            DBMS_OUTPUT.put_line (SUBSTR (s, 1, i - 1));
            show (SUBSTR (s, i + 1), maxlinelen, expand);
         ELSE
            -- No whitespace - split at max line length.
            i := maxlinelen;
            DBMS_OUTPUT.put_line (SUBSTR (s, 1, i));
            show (SUBSTR (s, i + 1), maxlinelen, expand);
         END IF;
      END IF;
   EXCEPTION
      WHEN output_buffer_overflow
      THEN
         IF NOT expand
         THEN
            RAISE;
         ELSE
            DBMS_OUTPUT.ENABLE (1000000);
            -- set false so won't expand again
            show (s, maxlinelen, FALSE);
         END IF;
   END;

   PROCEDURE showbanner (
      success_in   IN   BOOLEAN,
      program_in   IN   VARCHAR2,
      run_id_in    IN   utr_outcome.run_id%TYPE := NULL
   )
   IS
     program_name_and_run_id  VARCHAR2(2000);
   BEGIN
      IF success_in
      THEN
         utreport.pl ('. ');
         utreport.pl (
            '>    SSSS   U     U   CCC     CCC   EEEEEEE   SSSS     SSSS   '
         );
         utreport.pl (
            '>   S    S  U     U  C   C   C   C  E        S    S   S    S  '
         );
         utreport.pl (
            '>  S        U     U C     C C     C E       S        S        '
         );
         utreport.pl (
            '>   S       U     U C       C       E        S        S       '
         );
         utreport.pl (
            '>    SSSS   U     U C       C       EEEE      SSSS     SSSS   '
         );
         utreport.pl (
            '>        S  U     U C       C       E             S        S  '
         );
         utreport.pl (
            '>         S U     U C     C C     C E              S        S '
         );
         utreport.pl (
            '>   S    S   U   U   C   C   C   C  E        S    S   S    S  '
         );
         utreport.pl (
            '>    SSSS     UUU     CCC     CCC   EEEEEEE   SSSS     SSSS   '
         );
      ELSE
         utreport.pl ('. ');
         utreport.pl (
            '>  FFFFFFF   AA     III  L      U     U RRRRR   EEEEEEE '
         );
         utreport.pl (
            '>  F        A  A     I   L      U     U R    R  E       '
         );
         utreport.pl (
            '>  F       A    A    I   L      U     U R     R E       '
         );
         utreport.pl (
            '>  F      A      A   I   L      U     U R     R E       '
         );
         utreport.pl (
            '>  FFFF   A      A   I   L      U     U RRRRRR  EEEE    '
         );
         utreport.pl (
            '>  F      AAAAAAAA   I   L      U     U R   R   E       '
         );
         utreport.pl (
            '>  F      A      A   I   L      U     U R    R  E       '
         );
         utreport.pl (
            '>  F      A      A   I   L       U   U  R     R E       '
         );
         utreport.pl (
            '>  F      A      A  III  LLLLLLL  UUU   R     R EEEEEEE '
         );
      END IF;

      utreport.pl ('. ');
      program_name_and_run_id := '"'||NVL (program_in, 'Unnamed Test')||'"';
      IF run_id_in IS NOT NULL THEN
        program_name_and_run_id := program_name_and_run_id ||' Run ID: ' || run_id_in;
      END IF;
      IF success_in
      THEN
         utreport.pl (' SUCCESS: ' || program_name_and_run_id);
      ELSE
         utreport.pl (' FAILURE: ' || program_name_and_run_id);
      END IF;
      utreport.pl ('. ');
   END;

   PROCEDURE pl (str VARCHAR2)
   IS
   BEGIN
     show(str);
   END;

   PROCEDURE before_results(run_id IN utr_outcome.run_id%TYPE)
   IS
     v_packagename    ut_package.name%TYPE;
     v_owner          ut_package.owner%TYPE;
   BEGIN
     IF run_id IS NULL THEN
       v_packagename := utplsql.currpkg;
       v_owner :=  utplsql.currpkgowner;
     ELSE
       v_packagename := utpackage.name_from_last_run_id(last_run_id_in => run_id);
       v_owner :=  utpackage.owner_from_last_run_id(last_run_id_in => run_id);
     END IF;
      showbanner (utresult.success (run_id), v_owner||'.'||v_packagename, run_id);
      utreport.pl ('> Individual Test Case Results:');
      utreport.pl ('>');
      norows := TRUE;
   END;
   
   PROCEDURE show_failure
   IS
   BEGIN
     utreport.pl (utreport.outcome.description);
     utreport.pl ('>');
     norows := FALSE;     
   END;
   
   PROCEDURE show_result
   IS
   BEGIN
     utreport.pl (utreport.outcome.status || ' - ' || utreport.outcome.description);
     utreport.pl ('>');
     norows := FALSE;     
   END;
   
   PROCEDURE after_results(run_id IN utr_outcome.run_id%TYPE)
   IS
   BEGIN
     IF norows AND utconfig.showingfailuresonly 
     THEN
        utreport.pl ('> NO FAILURES FOUND');
     ELSIF norows
     THEN
        utreport.pl ('> NONE FOUND');
     END IF;
   END;
   
   PROCEDURE before_errors(run_id IN utr_error.run_id%TYPE)
   IS
   BEGIN      
      utreport.pl ('>');
      utreport.pl ('> Errors recorded in utPLSQL Error Log:');
      utreport.pl ('>');
      norows := TRUE ;
   END;
   
   PROCEDURE show_error
   IS
   BEGIN
     norows := FALSE ;
     utreport.pl (utreport.error.errlevel || ' - ' || utreport.error.errcode || ': ' || utreport.error.errtext);
   END;
   
   PROCEDURE after_errors(run_id IN utr_error.run_id%TYPE)
   IS
   BEGIN
     IF norows
     THEN
        utreport.pl ('> NONE FOUND');
     END IF;
   END;   
   
   /*
    proc: before_suite_results
      Show suite overall result banner and suite run stats
      
    parameters:
      suite_id - suite id
  */
  PROCEDURE before_suite_results(
    suite_id       ut_suite.id%TYPE
  )
  IS
    PROCEDURE show_suite_stats(
      suite_id       ut_suite.id%TYPE
    )
    IS
      SuiteStats utresult.TSuiteStats;
    BEGIN
      SuiteStats := utresult.get_suite_stats(suite_id => suite_id);
      utreport.pl('SUITE STATS: '||to_char(SuiteStats.succeededpackages)||' of '||to_char(SuiteStats.totalpackages)||' packages succeeded.');
      utreport.pl('SUITE STATS: '||to_char(SuiteStats.succeededasserts)||' of '||to_char(SuiteStats.totalasserts)||' individual test cases succeeded.');
      utreport.pl('.');
    END show_suite_stats;
    
    PROCEDURE showsuitebanner(
      suite_id       ut_suite.id%TYPE
    )
    IS
    BEGIN
      IF utresult.suite_success(suite_id => suite_id) THEN
        utreport.pl('.');
        utreport.pl('>   SSSS   U     U  III  TTTTTTT EEEEEEE        SSSS   U     U   CCC     CCC   EEEEEEE   SSSS     SSSS   ');
        utreport.pl('>  S    S  U     U   I      T    E             S    S  U     U  C   C   C   C  E        S    S   S    S  ');
        utreport.pl('> S        U     U   I      T    E            S        U     U C     C C     C E       S        S        ');
        utreport.pl('>  S       U     U   I      T    E             S       U     U C       C       E        S        S       ');
        utreport.pl('>   SSSS   U     U   I      T    EEEE           SSSS   U     U C       C       EEEE      SSSS     SSSS   ');
        utreport.pl('>       S  U     U   I      T    E                  S  U     U C       C       E             S        S  ');
        utreport.pl('>        S U     U   I      T    E                   S U     U C     C C     C E              S        S ');
        utreport.pl('>  S    S   U   U    I      T    E             S    S   U   U   C   C   C   C  E        S    S   S    S  ');
        utreport.pl('>   SSSS     UUU    III     T    EEEEEEE        SSSS     UUU     CCC     CCC   EEEEEEE   SSSS     SSSS   ');
        utreport.pl('.');
        utreport.pl('SUITE SUCCESS: "'||utsuite.name_from_id(id_in => suite_id)||'"');
      ELSE
        utreport.pl('.');
        utreport.pl('>    SSSS   U     U  III  TTTTTTT EEEEEEE     FFFFFFF   AA     III  L      U     U RRRRR   EEEEEEE ');
        utreport.pl('>   S    S  U     U   I      T    E           F        A  A     I   L      U     U R    R  E       ');
        utreport.pl('>  S        U     U   I      T    E           F       A    A    I   L      U     U R     R E       ');
        utreport.pl('>   S       U     U   I      T    E           F      A      A   I   L      U     U R     R E       ');
        utreport.pl('>    SSSS   U     U   I      T    EEEE        FFFF   A      A   I   L      U     U RRRRRR  EEEE    ');
        utreport.pl('>        S  U     U   I      T    E           F      AAAAAAAA   I   L      U     U R   R   E       ');
        utreport.pl('>         S U     U   I      T    E           F      A      A   I   L      U     U R    R  E       ');
        utreport.pl('>   S    S   U   U    I      T    E           F      A      A   I   L       U   U  R     R E       ');
        utreport.pl('>    SSSS     UUU    III     T    EEEEEEE     F      A      A  III  LLLLLLL  UUU   R     R EEEEEEE ');
        utreport.pl('.');
        utreport.pl('SUITE FAILURE: "'||utsuite.name_from_id(id_in => suite_id)||'"');
      END IF;
    END showsuitebanner;
    
  BEGIN
    showsuitebanner(suite_id => suite_id);
    show_suite_stats(suite_id => suite_id);
  END before_suite_results;
END;
/
