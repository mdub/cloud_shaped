class Symbol

  def camelate
    to_s.split("_").map(&:capitalize).join
  end

end

class String

  def camelate
    self
  end

end

class Hash

  def camelate_keys
    Hash[map { |key, value| [key.camelate, value] }]
  end

end
