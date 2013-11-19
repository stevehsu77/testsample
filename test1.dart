
import 'dart:core';
import 'dart:mirrors';
import 'lib/lib1.dart';

import 'dart:io';
import 'dart:convert';

void main(dynamic args)
{
  var x='lib1';
  var sss=CreateInstance(new Symbol(x),const Symbol('cls1'),['123']);
  sss.ppp('555');

  var hhh={};
  hhh['abc']='1';
  hhh['def']=2;
  hhh[1]=3;

  var r=reflect(sss);
  var f=r.getField(const Symbol('[]='));
  var s=r.getField(const Symbol('s'));
  ClosureMirror fc=r.getField(const Symbol('pp'));
  MethodMirror mc=fc.function;

  var ic=fc.apply(["ghggg"]);
  var xs=r.setField(new Symbol('s'),'789');
  var xs2=r.setField(new Symbol('ss'),'abc');
  var xs3=r.getField(new Symbol('ss'));
  var ss=s.reflectee;

  var httpclient=new HttpClient();
  httpclient.findProxy=(Uri uri)=>"PROXY 127.0.0.1:8888";
  httpclient.userAgent='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36';
  httpclient.badCertificateCallback=(x509, host, port){print(x509.toString()); return true;};
  var request=httpclient.getUrl(Uri.parse('http://www.sbobet.com/'))
      .then((HttpClientRequest req){
        req.followRedirects=true;
        //req.headers.set(HttpHeaders.ACCEPT,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8');
        //req.headers.set(HttpHeaders.ACCEPT_ENCODING,'gzip,deflate,sdch');
        //req.headers.set(HttpHeaders.ACCEPT_LANGUAGE,'zh-CN,zh;q=0.8');
        //req.headers.set(HttpHeaders.CONNECTION,'keep-alive');
        //req.persistentConnection=true;
        //req.maxRedirects=5;

        print('have request');
        return req.close();
        }, onError:null )
      .then((HttpClientResponse res){
        print('have response');
        print(res.isRedirect);
        res.transform(UTF8.decoder).toList().then((data) {
          print(data.length);
          var body = data.join('');
          print(body);
          httpclient.close();
        });
        }, onError: null);

  print('oen url');
}

/*
 * dart ssl3.2/tls1.1
  [0039]  TLS_DHE_RSA_WITH_AES_256_SHA
  [006B]  TLS_DHE_RSA_WITH_AES_256_CBC_SHA256
  v[0038]  TLS_DHE_DSS_WITH_AES_256_SHA
  v[0035]  TLS_RSA_AES_256_SHA
  [003D]  TLS_RSA_WITH_AES_256_CBC_SHA256
  [0033]  TLS_DHE_RSA_WITH_AES_128_SHA
  [0067]  TLS_DHE_RSA_WITH_AES_128_CBC_SHA256
  v[0032]  TLS_DHE_DSS_WITH_AES_128_SHA
  v[0005]  SSL_RSA_WITH_RC4_128_SHA
  v[0004]  SSL_RSA_WITH_RC4_128_MD5
  v[002F]  TLS_RSA_AES_128_SHA
  [003C]  TLS_RSA_WITH_AES_128_CBC_SHA256
  [0016]  SSL_DHE_RSA_WITH_3DES_EDE_SHA
  v[0013]  SSL_DHE_DSS_WITH_3DES_EDE_SHA
  v[000A]  SSL_RSA_WITH_3DES_EDE_SHA

  chrome ssl3.1/tls1.0
  v[C00A]  TLS1_CK_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
  v[C014]  TLS1_CK_ECDHE_RSA_WITH_AES_256_CBC_SHA
  [0039]  TLS_DHE_RSA_WITH_AES_256_SHA
  [006B]  TLS_DHE_RSA_WITH_AES_256_CBC_SHA256
  v[0035]  TLS_RSA_AES_256_SHA
  [003D]  TLS_RSA_WITH_AES_256_CBC_SHA256
  [C007]  TLS_ECDHE_ECDSA_WITH_RC4_128_SHA
  v[C009]  TLS1_CK_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
  [C023]  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
  [C011]  TLS_ECDHE_RSA_WITH_RC4_128_SHA
  v[C013]  TLS1_CK_ECDHE_RSA_WITH_AES_128_CBC_SHA
  [C027]  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
  [0033]  TLS_DHE_RSA_WITH_AES_128_SHA
  [0067]  TLS_DHE_RSA_WITH_AES_128_CBC_SHA256
  v[0032]  TLS_DHE_DSS_WITH_AES_128_SHA
  v[0005]  SSL_RSA_WITH_RC4_128_SHA
  v[0004]  SSL_RSA_WITH_RC4_128_MD5
  v[002F]  TLS_RSA_AES_128_SHA
  [003C]  TLS_RSA_WITH_AES_128_CBC_SHA256
  v[000A]  SSL_RSA_WITH_3DES_EDE_SHA

  ie ssl3.1/tls1.0
  [002F]  TLS_RSA_AES_128_SHA
  [0035]  TLS_RSA_AES_256_SHA
  [0005]  SSL_RSA_WITH_RC4_128_SHA
  [000A]  SSL_RSA_WITH_3DES_EDE_SHA
  xd[C013]  TLS1_CK_ECDHE_RSA_WITH_AES_128_CBC_SHA
  xd[C014]  TLS1_CK_ECDHE_RSA_WITH_AES_256_CBC_SHA
  xd[C009]  TLS1_CK_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
  xd[C00A]  TLS1_CK_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
  [0032]  TLS_DHE_DSS_WITH_AES_128_SHA
  xc[0038]  TLS_DHE_DSS_WITH_AES_256_SHA
  [0013]  SSL_DHE_DSS_WITH_3DES_EDE_SHA
  [0004]  SSL_RSA_WITH_RC4_128_MD5
 */
dynamic CreateInstance(Symbol libraryname,Symbol classname,List arguments)
{
  MirrorSystem mirrors = currentMirrorSystem();
  LibraryMirror libmirror = mirrors.findLibrary(libraryname);
  ClassMirror clsmirror = libmirror.declarations[classname];
  InstanceMirror insmirror = clsmirror.newInstance(const Symbol(''),arguments);
  return insmirror.reflectee;

}