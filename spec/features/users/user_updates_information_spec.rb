require 'rails-helper'

# As a prospective user
# I want to create an account
# So that I can post items and review them

# As an authenticated user
# I want to update my information
# So that I can keep my profile up to date

# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app







# feature 'user signs in', %Q{
#   As an unauthenticated user
#   I want to sign in
#   So that I can post items and review them
#   }
# scenario 'User signs in' do
#   user = FactoryGirl.create(:user)
#
#   visit root
#   click_button 'Sign in'
#
#   fill_in 'Email', with: user.email
#   fill_in 'Password', with: user.password
#
#
#
#   expect(page).to have_content('Welcome! You have signed in successfully.')
#   expect(page).to have_content('Sign Out')
# end

# feature 'user signs out', %Q{
#   As an authenticated user
#   I want to sign out
#   So that no one else can post items or reviews on my behalf
# }

# scenario 'user signs out' do
#   user = FactoryGirl.create(:user)
#
#   visit root
#
#   fill_in 'Email', with: user.email
#   fill_in 'Password', with: user.password
#   click_button 'Sign in'
#   click_button 'Sign out'
#
#   expect(page).to have_content('You have signed out successfully.')
#   expect(page).to have_content('Sign in')



  feature 'user updates user information', %Q{
    As a signed in user, I want to be able to
    update my user information
  } do

  scenario 'update user information' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    visit root
    click_button 'Sign in'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password

    click_button 'My account'
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.email

    click_button 'Save changes'

    expect(page).to have_content(user2.email)  #is there a way to show 'email field contains? user2.email'
    expect(page).to have_content(user2.password) #same for password, assumed after  redirect back to account info?
  end

end
