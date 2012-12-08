module Handleapi
  # In this module I will include the methods needed to process the response received from the HN API
  def get_array_with_points(items)
    points_array = items.collect do |item|
                      item.values[4]
                   end
    return points_array
  end
  
  def calculate_mean_for_HN_items(points_array)
    return points_array.inject{ |sum, element| sum + element }.to_f / points_array.size
  end
  
  def calculate_median_for_HN_items(points_array)
    sorted = points_array.sort
    mid = points_array.size/2
    sorted[mid]
  end
  
  def calculate_mode_for_HN_items(points_array)
    freq = points_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    points_array.sort_by { |v| freq[v] }.last
  end
end