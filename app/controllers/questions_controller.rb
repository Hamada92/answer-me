class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :show_from_my_university]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :set_autocomplete, only: [:new, :edit, :create, :update]

  def index
    @questions = Question.paginate(per_page: 10, page: params[:page]).includes(:tags, :likes)
    @universities = Tag.all_universities
  end

  def show
  end

  def new
    @question = Question.new
    @question.tags.build
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @question.destroy
        format.html { redirect_to authenticated_root_path, notice: 'Questions was deleted.' }
      else
        format.html {
          flash[:alert] = 'Answered questions cannot be deleted.'
          render :show
        }
      end
    end
  end

  def unanswered_with_tag
    @tag = Tag.find(params[:tag_id])
    @unanswered_questions = @tag.unanswered_questions.paginate(per_page: 10, page: params[:page])
  end

  def show_from_my_university
    @university = current_user.university
    @questions_from_university = Question.tagged_with_university(@university).paginate(per_page: 10, page: params[:page]).includes(:tags, :likes)
    @tags = Tag.with_university @university
    render :show_from_university
  end

  def show_from_university
    @university = params[:university]
    @questions_from_university = Question.tagged_with_university(@university).paginate(per_page: 10, page: params[:page]).includes(:tags, :likes)
    @tags = Tag.with_university @university
  end

  def show_with_tag
    @tag = Tag.find(params[:tag_id])
    @questions_with_tag = @tag.questions.includes(:likes).paginate(per_page: 10, page: params[:page])
  end

  private

    def question_params
      params.require(:question).permit(:title, :body, :tag_category, :tag_name)
    end

    def set_question
      @question = Question.find(params[:id])
      @answer = Answer.new
    end

    def set_autocomplete
      university = current_user.university
      @course_tags = Tag.names_with(university, "Course Related")
      @program_tags = Tag.names_with(university, "Program Related")
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's question."
        redirect_to @question
      end
    end

end
