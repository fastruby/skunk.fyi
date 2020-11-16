module ReportsHelper
  def cell_class(key)
    key == "file" ? "left" : "right"
  end
end
