# frozen_string_literal: true

class PreferencesController < ApplicationController
  before_action :authenticate_user_using_x_auth_token
  before_action :load_preference

  def show
    render status: :ok, json: { preference: @preference }
  end

  def update
    if @preference.update(preference_params)
      render status: :ok, json: {
        notice: t("successfully_updated", entity: "Preference")
      }
    else
      error = @preference.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error }
    end
  end

  private

    def preference_params
      params.require(:preference).permit(:notification_delivery_hour, :receive_email)
    end

    def load_preference
      @preference = current_user.preference
      unless @preference
        render status: :not_found, json: { error: t("not_found", entity: "Preference") }
      end
    end
end
