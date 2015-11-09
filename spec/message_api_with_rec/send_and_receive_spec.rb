describe 'cross session communication package message_api_with_rec' do

  it 'allows sending and receiving messages within single database session' do
    a_message = { msg_number: 1, msg_text: 'a message', msg_date: Time.today }
    plsql.message_api_with_rec.send_msg( a_message )
    expect( plsql.message_api_with_rec.receive_msg ).to eq( a_message )
  end

  it 'allows sending and receiving messages across different sessions of the same user' do
    a_message = { msg_number: 1, msg_text: 'a message', msg_date: Time.today }
    plsql(:main_session).message_api_with_rec.send_msg( a_message )
    expect( plsql(:another_session).message_api_with_rec.receive_msg ).to eq( a_message )
  end

  it 'allows sending and receiving messages across sessions of different users' do
    a_message = { msg_number: 1, msg_text: 'a message', msg_date: Time.today }
    plsql.message_api_with_rec.send_msg( a_message )
    expect( plsql(:different_user).message_api_with_rec.receive_msg ).to eq( a_message )
  end

end
