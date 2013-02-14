<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>
    <title>OddPrints${param.titleText}</title>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
    <meta property="og:title" content="OddPrints"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="http://www.oddprints.com"/>
    <meta property="og:image" content="http://www.oddprints.com/images/icon128.png"/>
    <meta property="og:site_name" content="OddPrints"/>
    <meta property="fb:admins" content="565140267, 565740296"/>
    <meta property="og:description" content="${param.descriptionText}"/>
          
    <meta name="Description" content="${param.descriptionText}" />
          
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link type="text/css" rel="stylesheet" href="/css/jquery.mobile-1.2.0.min.css" />
    <link type="text/css" rel="stylesheet" href="/css/oddprints.css?ver=1" />
    <link type="text/css" rel="stylesheet" href="/css/jquery.miniColors.css" />
    <script type="text/javascript" src="/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery.mobile-1.2.0.min.js"></script>
    <script type="text/javascript" src="/js/jquery-ui-1.9.0.custom.min.js"></script>
    <script type="text/javascript" src="/js/modernizr.custom.11873.js"></script>
    <script type="text/javascript" src="/js/oddprints.js?ver=1"></script>
    <script type="text/javascript" src="/js/jquery.tinycarousel.min.js"></script>
    <script type="text/javascript" src="/js/jquery.miniColors.min.js"></script>
</head>

<c:set var="html_year" scope="application" value='<%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>'/>
