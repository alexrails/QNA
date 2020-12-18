require 'rails_helper'

feature 'User can delete answer', '
  I want to be able
  Delete answer
' do
  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, user: users.first) }

  background do
    sign_in(users.first)
  end

  scenario 'Author tries delete own answer' do
    answer = create(:answer, question: question, user: users.first)

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to have_no_content answer.body
  end

  scenario 'User tries delete another answer' do
    answer = create(:answer, question: question, user: users.last)

    visit question_path(question)
    expect(page).to_not have_link('Delete')
  end
end
