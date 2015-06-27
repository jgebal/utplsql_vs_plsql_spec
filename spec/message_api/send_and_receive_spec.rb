require_relative '../spec_helper'

describe 'cross session communication package' do

  it 'allows receiving message sent in one session' do
    a_message = { p_number: 1, p_text: 'a message', p_date: Time.today }
    plsql.message_api.send_msg( a_message )
    expect( plsql.message_api.receive_msg ).to eq( a_message )
  end

  it 'allows sending and receiving message across different sessions' do
    message_values = [ 1, 'a message', Time.today ]
    plsql(:default).message_api.send_msg( *message_values )
    received_values = plsql(:secondary).message_api.receive_msg.values
    expect( received_values ).to eq( message_values )
  end

  it 'allows sending and receiving message across sessions of different users' do
    # a very PL/SQL'ish style of code
    a_number = 1
    a_text = 'a message'
    a_date = Time.today
    plsql.message_api.send_msg( a_number, a_text, a_date)

    result = plsql(:different_user).message_api.receive_msg

    expect( result[:p_number] ).to eq( a_number )
    expect( result[:p_text] ).to eq( a_text )
    expect( result[:p_date] ).to eq( a_date )
  end

end
