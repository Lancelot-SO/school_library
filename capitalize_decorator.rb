require_relative 'decorator'
# Capitalize Decorator Class
class CapitalizeDecorator < Decorator
  def correct_name
    nameable.correct_name.capitalize
  end
end
