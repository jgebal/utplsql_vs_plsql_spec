describe 'session communication package' do

  it 'allows receiving a message sent within a session' do
    a_message = { p_number: 1, p_text: 'a message', p_date: Time.today } #GIVEN
    plsql.message_api.send_msg( a_message )                              #WHEN
    expect( plsql.message_api.receive_msg ).to eq( a_message )           #THEN
  end

end
