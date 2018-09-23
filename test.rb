hh = { 'aa' => 'bb', 'dd' => 'dd' }

print hh.each_key do |a|
  print hh[a]
end
