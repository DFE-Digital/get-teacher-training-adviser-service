class ModelWizard
  attr_reader :object

  def initialize(object, session, params=nil, object_params=nil)
    @object = object
    @session = session
    @params = params
    @object_params = object_params
    @param_key = ActiveModel::Naming.param_key(object)
    @session_params = "#{@param_key}_params".to_sym
  end

  def start
    @session[@session_params] = {}
    @object = load_object
    self
  end

  def continue 
    byebug
    @session[@session_params].deep_merge!(@object_params.to_unsafe_h) if @object_params
    @object = load_object
    @object.assign_attributes(@session[@session_params]) unless class?
    save
    self
  end

  def save
    if @object.valid?
      return process_save
    end
    false
  end

  private

  def load_object
    class? ? @object.new(@session[@session_params]) : @object
  end

  def class?
    @object.is_a?(Class)
  end

  def process_save
    @session[:registration] ||= {} # create session[:registration] if nil on first pass
    @session[:registration].merge!(@object.attributes.compact)
    @session[@session_params] = nil
    @session[:last_valid_step] = @object.class
    return @session[:registration]
  end
end