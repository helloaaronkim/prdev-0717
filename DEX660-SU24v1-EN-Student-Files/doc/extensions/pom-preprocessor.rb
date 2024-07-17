RUBY_ENGINE == 'opal' ? (require 'pom-preprocessor/extension') : (require_relative 'pom-preprocessor/extension')

Asciidoctor::Extensions.register do
  preprocessor PomPreprocessor
end