class BeanBuilder
  DEFAULTS = {
    decaf: false,
    rating: 0
  }.freeze

  def initialize
    @bean = Bean.new
  end

  def set_required_bean_attributes(user_id, name, origin, process, roast_level)
    @bean.user_id = user_id
    @bean.name = name
    @bean.origin = origin
    @bean.process = process
    @bean.roastlevel = roast_level
    self
  end

  def set_rating(rating)
    @bean.rating = rating || DEFAULTS[:rating]
    self
  end

  def set_decaf(decaf)
    @bean.decaf = decaf || DEFAULTS[:decaf]
    self
  end

  def log_changes
    Rails.logger.info("Building Bean: #{@bean.attributes}")
    self
  end

  def build
    raise ActiveRecord::RecordInvalid, @bean unless @bean.valid?

    @bean.save
    @bean
  end
end
