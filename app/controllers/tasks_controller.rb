# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :authenticate_user_using_x_auth_token
  before_action :load_task, only: %i[show update destroy]
  before_action :ensure_authorized_update_to_restricted_attrs, only: %i[update]

  def index
    tasks = policy_scope(Task)
    @pending_tasks = tasks.pending.includes(:assigned_user)
    @completed_tasks = tasks.completed
  end

  def create
    task = current_user.created_tasks.new(task_params)
    authorize task
    if task.save
      render status: :ok,
        json: { notice: t("successfully_created", entity: "Task") }
    else
      error = task.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error }
    end
  end

  def show
    authorize @task
    @comments = @task.comments.order("created_at DESC")
  end

  def update
    authorize @task
    if @task.update(task_params)
      render status: :ok, json: {}
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  def destroy
    authorize @task
    if @task.destroy
      render status: :ok, json: {}
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :assigned_user_id, :progress)
    end

    def ensure_authorized_update_to_restricted_attrs
      is_editing_restricted_params = Task::RESTRICTED_ATTRIBUTES.any? { |a| task_params.key?(a) }
      is_not_owner = @task.task_owner_id != @current_user.id
      if is_editing_restricted_params && is_not_owner
        handle_authorization_error
      end
    end

    def load_task
      @task = Task.find_by(slug: params[:slug])
      unless @task
        render status: :not_found, json: { error: t("task.not_found") }
      end
    end
end
