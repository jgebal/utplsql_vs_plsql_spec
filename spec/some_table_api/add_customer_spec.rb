describe 'Add a new customer' do

  def count_customers(customer_id, customer_no)
    plsql.customers.count( 'WHERE customer_id = :customer_id OR customer_no = :customer_no', customer_id, customer_no )
  end

  it 'adds a new customer to the table' do
    customer_id, customer_no = -1, 1234
    #GIVEN
    expect( count_customers( customer_id, customer_no  ) ).to eq( 0 )
    #WHEN
    plsql.some_table_api.add_customer( customer_id, customer_no, '1' )
    #THEN
    expect( count_customers( customer_id, customer_no ) ).to eq( 1 )
  end

  it 'fails to add a new customer on PK' do
    customer_id, customer_no = -1, 1234
    #GIVEN
    expect( count_customers( customer_id, customer_no ) ).to eq( 0 )
    #WHEN
    plsql.some_table_api.add_customer( customer_id, customer_no, '1' )
    #THEN
    expect{ plsql.some_table_api.add_customer( customer_id, customer_no+1, '1' ) }.to raise_exception(/CUSTOMERS_PK/)
  end

  it 'fails to add a new customer on UK' do
    customer_id, customer_no = -1, 1234
    #GIVEN
    expect( count_customers( customer_id, customer_no ) ).to eq( 0 )
    #WHEN
    plsql.some_table_api.add_customer( customer_id, customer_no, '1' )
    #THEN
    expect{ plsql.some_table_api.add_customer( customer_id-1, customer_no, '1' ) }.to raise_exception(/ORA-00001/)
  end

end
