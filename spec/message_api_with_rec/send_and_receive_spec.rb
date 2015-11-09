describe 'cross session communication package message_api_with_rec' do

  it 'allows sending and receiving messages within single database session' do
    a_message = { msg_number: 1, msg_text: 'a message', msg_date: Time.today }
    plsql.message_api_with_rec.send_msg( a_message )
    expect( plsql.message_api_with_rec.receive_msg ).to eq( a_message )
  end

  it 'allows sending and receiving messages across different sessions of the same user' do
    a_message = { msg_number: 2, msg_text: 'different message', msg_date: Time.today - 1 }
    plsql(:main_session).message_api_with_rec.send_msg( a_message )
    expect( plsql(:another_session).message_api_with_rec.receive_msg ).to eq( a_message )
  end

  it 'allows sending and receiving messages across sessions of different users' do
    a_message = { msg_number: 3, msg_text: 'message for another user', msg_date: Time.today + 1 }
    plsql.message_api_with_rec.send_msg( a_message )
    expect( plsql(:different_user).message_api_with_rec.receive_msg ).to eq( a_message )
  end

end
