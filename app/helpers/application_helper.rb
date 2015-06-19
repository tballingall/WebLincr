#
module ApplicationHelper
  # query: Field-level errors
  #
  # Returns a list of errors
  #
  # @return  [string]
  #
  def display_any_errors_for(model:, text:)
    return _render_errors(model, text) if model.errors.any?
    ''
  end

  # query: Main nav item for registration links
  #
  # Returns an anchor element wrapped in a list item
  #
  # @return [string]
  #
  def nav_item_registration
    content_tag :li, registration_link
  end

  private

  def _render_errors(model, text)
    "#{error_count(model, text)} #{error_messages(model)}".html_safe
  end

  def error_count(model, text)
    content_tag(:h2, "#{pluralize(model.errors.count, 'error')} #{text}")
  end

  def error_messages(model)
    content_tag :ul do
      model.errors.full_messages.map do |message|
        concat(content_tag(:li, message))
      end
    end
  end

  def registration_link
    link_to(I18n.t('user.sign_up.link'), new_user_path)
  end
end
