require 'rails_helper'

feature 'User can create answer', %q{
  In order to write answer for community question
  As an authenticated user
  I'd like to answer question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'answer a question' do
      fill_in 'Body', with: 'Test answer'
      click_on 'Answer a question'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'Test answer'
    end

    scenario 'answer question with errors' do
      click_on 'Answer a question'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer a question' do
    visit question_path(question)

    click_on 'Answer a question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
