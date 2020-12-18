class AnswersController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer.question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    answer.update(answer_params) if current_user.author_of?(answer)
  end

  def destroy
    return unless current_user.author_of?(answer)

    answer.destroy
    redirect_to answer.question, notice: 'Your answer successfully deleted.'
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  helper_method :answer
  helper_method :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
