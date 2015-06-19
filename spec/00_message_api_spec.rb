require_relative 'spec_helper'

describe 'cross session communication' do

  it 'message can be sent and received in one session' do
    # a very PL/SQL'ish style of code
    a_number = 1
    a_text = 'a message'
    a_date = Time.today
    plsql.message_api.send_msg( a_number, a_text, a_date)

    result = plsql.message_api.receive_msg

    expect( result[:p_number] ).to eq( a_number )
    expect( result[:p_text] ).to eq( a_text )
    expect( result[:p_date] ).to eq( a_date )
  end

  it 'message can be sent and received across session' do
    # more Ruby'ish style of code
    a_message = [ 1, 'a message', Time.today ]
    plsql.message_api.send_msg( *a_message )
    received_values = plsql(:secondary).message_api.receive_msg.values
    expect( received_values ).to eq( a_message )
  end

  it 'message can be sent and received across sessions of different users' do
    # lots of calls can be inlined to make things more dense
    a_message = [ 1, 'a message', Time.today ]
    plsql(:default).message_api.send_msg *a_message
    expect( plsql(:different_user).message_api.receive_msg.values ).to  eq a_message
  end

end
