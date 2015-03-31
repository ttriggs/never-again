scenario 'user forgets password, make new one' do
  visit root
  click_button 'Sign in'
  click_link 'Forgot your password?'

  expect(page).to have_content('Email')
  expect(page).to have_content('Send me reset password instructions')
end
