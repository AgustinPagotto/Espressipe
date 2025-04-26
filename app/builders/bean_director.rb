class BeanDirector
  def initialize(builder)
    @builder = builder
  end

  def build_simple_bean
    @builder.set_required_bean_attributes(
      current_user.id,
      'Coffe Example',
      'colombia',
      'washed',
      'dark'
    )
  end
end
