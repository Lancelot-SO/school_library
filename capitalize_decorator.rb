require_relative 'decorator'
# CapitalizeDecorator class
class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end
