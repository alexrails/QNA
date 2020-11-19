require 'rails_helper'

feature 'User can show list of questions', %q{
  I'd like to be able show all my questions
} do

  given!(:questions) { create_list(:question, 3) }
  scenario 'Show questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)
    end
  end
end
