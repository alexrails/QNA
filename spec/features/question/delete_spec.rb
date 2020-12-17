require 'rails_helper'

feature 'User can delete question', %q{
  I want to be able
  Delete question
}do

  given(:users) { create_list(:user, 2) }

  background do
    sign_in(users.first)
  end

  scenario 'Author tries delete own question' do
    question = create(:question, user: users.first)

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'Your question successfully deleted.'
    expect(page).to have_no_content question.title
  end

  scenario 'User tries delete another question' do
    question = create(:question, user: users.last)

    visit questions_path
    expect(page).to_not have_link('Delete')
  end
end
