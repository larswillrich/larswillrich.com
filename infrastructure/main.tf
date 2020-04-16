resource "aws_s3_bucket" "lars-willrich-static-website" {
  bucket = "larswillrich.com"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "root_domain" {
  zone_id = aws_route53_zone.main.zone_id
  name = var.domain
  type = "A"

  alias {
    name    = aws_s3_bucket.lars-willrich-static-website.website_domain
    zone_id = aws_s3_bucket.lars-willrich-static-website.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "larswillrich.com"
  type    = "NS"
  ttl     = "172800"

  records = [
    "${aws_route53_zone.main.name_servers.0}",
    "${aws_route53_zone.main.name_servers.1}",
    "${aws_route53_zone.main.name_servers.2}",
    "${aws_route53_zone.main.name_servers.3}",
  ]
}