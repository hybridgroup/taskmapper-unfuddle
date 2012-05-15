require File.dirname(__FILE__) + '/unfuddle/unfuddle-api'

%w{ unfuddle ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
