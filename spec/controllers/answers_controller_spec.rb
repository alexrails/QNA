require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect{ post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'created Answer belongs to current user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }

        expect(assigns(:answer).user).to eq user
      end

      it 'redirects to question view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect{ post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 're-renders show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:users) { create_list(:user, 2) }
    before { login(users.first) }
    context 'own answer' do
      let!(:answer) { create(:answer, question: question, user: users.first)}

      it 'deletes the answer' do
        expect{ delete :destroy, params: { id: answer }  }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'another question' do
      let!(:answer) { create(:answer, question: question, user: users.last) }

      it 'do not delete answer' do
        expect{ delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
    end
  end
end
