require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'
require 'nokogiri'

class PomPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
   
  doc = Nokogiri::XML(open("../../solutions/bom/pom.xml")) 
  doc.remove_namespaces!
  props = doc.xpath('//project/properties')
  document.attributes['MRPVersion'.downcase] = props.xpath('//resources.plugin.version').text
  document.attributes['MRSemVersion'.downcase] = props.xpath('//app.runtime.semver').text
  document.attributes['MRVersion'.downcase] = props.xpath('//app.runtime').text
  document.attributes['MMPVersion'.downcase] = props.xpath('//mule.maven.plugin.version').text
  document.attributes['MEMPVersion'.downcase] = props.xpath('//mule.extensions.maven.plugin.version').text
  document.attributes['MUMPVersion'.downcase] = props.xpath('//munit.version').text
  document.attributes['EMMPVersion'.downcase] = props.xpath('//exchange.mule.maven.plugin.version').text
  document.attributes['AKitVersion'.downcase] = props.xpath('//apikit.version').text
  document.attributes['SecPropsVersion'.downcase] = props.xpath('//secure.conf.prop.module.version').text
  document.attributes['ValModVersion'.downcase] = props.xpath('//validation.module.version').text
  document.attributes['JsonModVersion'.downcase] = props.xpath('//json.module.version').text
  document.attributes['XmlModVersion'.downcase] = props.xpath('//xml.module.version').text
  document.attributes['OA2Version'.downcase] = props.xpath('//oauth.module.version').text
  document.attributes['HTTPConnVersion'.downcase] = props.xpath('//http.connector.version').text
  document.attributes['DBConnVersion'.downcase] = props.xpath('//db.connector.version').text
  document.attributes['OStoreVersion'.downcase] = props.xpath('//objectstore.connector.version').text
  document.attributes['WSCVersion'.downcase] = props.xpath('//wsc.connector.version').text
  document.attributes['VMConnVersion'.downcase] = props.xpath('//vm.connector.version').text
  document.attributes['AMQConnVersion'.downcase] = props.xpath('//anypoint.mq.connector.version').text
  document.attributes['SFTPConnVersion'.downcase] = props.xpath('//sftp.connector.version').text
  document.attributes['FileConnVersion'.downcase] = props.xpath('//file.connector.version').text
  document.attributes['EmailConnVersion'.downcase] = props.xpath('//email.connector.version').text
  document.attributes['TracingModuleVersion'.downcase] = props.xpath('//tracing.module.version').text
  document.attributes['FMSAPIVersion'.downcase] = props.xpath('//flights-management-sapi.version').text
  document.attributes['PDSAPIVersion'.downcase] = props.xpath('//passenger-data-sapi.version').text
  document.attributes['PPSAPIVersion'.downcase] = props.xpath('//paypal-sapi.version').text

  return reader
  end
end