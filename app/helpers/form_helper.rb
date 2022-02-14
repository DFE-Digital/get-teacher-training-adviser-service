module FormHelper
  def timed_one_time_password_label(code_resent)
    text = t("helpers.hint.wizard_steps_authenticate.timed_one_time_password.text")

    if code_resent
      text += "<br><b>#{t('helpers.hint.wizard_steps_authenticate.timed_one_time_password.resent')}</b>"
    end

    safe_html_format(text)
  end
end
