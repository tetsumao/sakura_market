class DiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @diaries = Diary.includes(:user).page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to root_path, notice: '日記を投稿しました'
    else
      redirect_to root_path, alert: @diary.toastr_error_message('日記を投稿できませんでした：')
    end
  end

  def gooded_users
    @diary = Diary.find(params[:id])
  end

  private
    def diary_params
      params.require(:diary).permit(:content, :picture)
    end
end
