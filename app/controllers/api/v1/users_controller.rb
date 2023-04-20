class Api::V1::UsersController < ApplicationController
  # before_action :users, only: [:index, :create]
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    render json: @users
  end

  def create
    contract = UserContract.new
    errors = contract.call(first_name: params["first_name"], last_name: params["last_name"], phone_number: params["phone_number"], college_id: params["college_id"], exam_id: params["exam_id"], start_time: params["start_time"]).errors.to_h
    if errors.present?
      render json: {error: errors}
    elsif User.find_by(first_name: user_params["first_name"], last_name: user_params["last_name"], phone_number: params["phone_number"], college_id: params["college_id"], exam_id: params["exam_id"]).present?
      render json: {error: {user: ["a user fails to be found or created, or failed to get associated with the exam"]}}, status: 400
    else
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: {error: @user.errors.full_messages}, status: 400
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :college_id, :exam_id, :phone_number)
  end

end
