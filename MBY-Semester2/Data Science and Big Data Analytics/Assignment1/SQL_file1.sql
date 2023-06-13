-- Creates a Table cloudfront_logs if it does not already exist
CREATE EXTERNAL TABLE IF NOT EXISTS cloudfront_logs (
  DateLog DATE,
  Time STRING,
  Location STRING,
  Bytes INT,
  RequestIP STRING,
  Method STRING,
  Host STRING,
  Uri STRING,
  Status INT,
  Referrer STRING,
  OS STRING,
  Browser STRING,
  BrowserVersion STRING
)
-- Converts rows into column using the RegEx expression
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "^(?!#)([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+[^\(]+[\(]([^\;]+).*\%20([^\/]+)[\/](.*)$"
) LOCATION '${INPUT}/cloudfront/data';

-- Total requests per browser for a given time frame
INSERT OVERWRITE DIRECTORY '${OUTPUT}/groupby_requests/'
SELECT LOCATION,browser,'->',COUNT (*) FROM cloudfront_logs WHERE DateLog BETWEEN '2014-07-05' AND '2014-08-05' GROUP BY LOCATION,browser;
