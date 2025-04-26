class BeanDirector
  def initialize(builder)
    @builder = builder
  end

  def build_example_bean(user_id)
    @builder.set_required_bean_attributes(
      user_id,
      'Coffe Example',
      'colombia',
      'washed',
      'dark'
    ).set_decaf(true).build
  end
end
