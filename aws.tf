data "aws_route53_zone" "getsysadmin_com" {
  provider     = aws
  name         = "getsysadmin.com."
  private_zone = false
}

resource "aws_route53_record" "hashitalks_latam_getsysadmin_com" {
  provider = aws
  name     = "hashitalks-latam.getsysadmin.com"
  type     = "CNAME"
  zone_id  = data.aws_route53_zone.getsysadmin_com.id
  records  = [ heroku_domain.hashitalks_latam.cname ]
  ttl      = 60
}
