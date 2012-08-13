<%--
Copyright 2011 Matt Burns

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>

<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:og="http://ogp.me/ns#"
      xmlns:fb="http://www.facebook.com/2008/fbml"
      xmlns:c="http://java.sun.com/jsp/jstl/core">
      
<jsp:include page="/WEB-INF/jsp/parts/html-head.jsp">
    <jsp:param name="titleText" value=" - Orders" />
    <jsp:param name="descriptionText" value="Views the current status of your order." />
</jsp:include>
<body>

<div data-role="page" id="page-orders">

    <jsp:include page="/WEB-INF/jsp/parts/page-header.jsp" />

    <div data-role="content">
           
        <c:if test="${it.userIsAdmin and not empty it.states}">
            <select name="order-state-choice" id="order-state-choice-id" >
                <c:forEach var="state" items="${it.states}">
                    <c:choose>
                        <c:when test="${state eq it.currentState}">
                            <c:set var="selectedAttribute" value="selected='selected'"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="selectedAttribute" value=""/>
                        </c:otherwise>
                    </c:choose>
                   <option value="${state}" ${selectedAttribute}>${state}</option>
                </c:forEach>
            </select>
        </c:if>
        
        <c:forEach var="order" items="${it.orders}">
            
            <h1>Order</h1>
            
            <c:if test="${it.userIsAdmin and order.state eq 'payment_received'}">
                <a href="${order.submitUrl}" data-ajax="false">Submit to Pwinty</a>
            </c:if>
            
            <div class="order-details">
                <dl>
                    <dt>Status:</dt> <dd>${order.state.userFriendlyStatus}&nbsp;</dd>
                    <dt>Order Created:</dt> <dd>${order.created}&nbsp;</dd>
                    
                    <c:if test="${it.userIsAdmin}">
                        <dt>Environment:</dt> <dd>${order.environment}&nbsp;</dd>
                    </c:if>
                    
                    <c:set var="pwintyOrder" value="${order.pwintyOrderEL}"/>
                    <c:if test="${not empty pwintyOrder}">
                        
                        <c:if test="${it.userIsAdmin}">
                            <dt>Pwinty status:</dt> <dd>${pwintyOrder.status}&nbsp;</dd>
                        </c:if>
                        
                        <c:forEach var="generalError" items="${pwintyOrder.submissionStatus.generalErrors}">
                            <dt>General error:</dt> <dd>${generalError}&nbsp;</dd>
                        </c:forEach>
                    </c:if>
                    
                    <c:if test="${not empty order.googleOrderNumber}">
                        <dt>Order Number:</dt> <dd> #${order.googleOrderNumber}&nbsp;</dd>

                        <c:set var="orderSummary" value="${order.googleOrderSummary}"/>
                        <c:if test="${not empty orderSummary}">
            
                            <dt>Contact Name:</dt> <dd>${orderSummary.buyerShippingAddress.contactName}&nbsp;</dd>
                            <dt>Address 1:</dt> <dd>${orderSummary.buyerShippingAddress.address1}&nbsp;</dd>
                            <dt>Address 2:</dt> <dd>${orderSummary.buyerShippingAddress.address2}&nbsp;</dd>
                            <dt>City:</dt> <dd>${orderSummary.buyerShippingAddress.city}&nbsp;</dd>
                            <dt>Region:</dt> <dd>${orderSummary.buyerShippingAddress.region}&nbsp;</dd>
                            <dt>Postal Code:</dt> <dd>${orderSummary.buyerShippingAddress.postalCode}&nbsp;</dd>
                            <dt>Country Code:</dt> <dd>${orderSummary.buyerShippingAddress.countryCode}&nbsp;</dd>
                            <dt>Purchase Date:</dt> <dd>${orderSummary.purchaseDate}&nbsp;</dd>
                        </c:if>
                    </c:if>
                </dl>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th class="quantity-input-column">Quantity</th>
                        <th>Frame</th>
                        <th>Print</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="basketItem" items="${order.items}" varStatus="basketItemNumber">
                        <tr>
                            <td class="text-align-left">
                                <a href="${basketItem.fullImageUrl}" data-ajax="false">
                                    <img class="checkout-thumb" style="background:url(${basketItem.thumbImageUrl}) no-repeat center;" src="/images/mag.png" alt="" />
                                </a>
                            </td>
                            <td>
                                <c:if test="${not empty order.pwintyOrderEL}">
                                    <c:forEach var="photoStatus" items="${order.pwintyOrderEL.submissionStatus.photos}" varStatus="photoNumber">
                                        <c:if test="${basketItemNumber eq photoNumber}">
                                            <c:forEach var="photoError" items="${photoStatus.errors}">
                                                <b>Error:</b> ${photoError}<br/>
                                            </c:forEach>
                                            <c:forEach var="photoWarning" items="${photoStatus.warnings}">
                                                <b>Warning:</b> ${photoWarning}<br/>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </td>
                            <td>${basketItem.quantity}</td>
                            <td>${basketItem.frameSize}</td>
                            <td>${basketItem.printSize.displayString}</td>
                            <td>${basketItem.priceString}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${it.userIsAdmin}">
                <div class="temp-admin-thing" style="background-color: #cfc">
                    <p>This is just a temporary block to check the pwinty errors and warnings are appearing correctly.</p>
                    <c:if test="${not empty order.pwintyOrderEL}">
                        <c:forEach var="photoStatus" items="${order.pwintyOrderEL.submissionStatus.photos}">
                            <c:forEach var="photoError" items="${photoStatus.errors}">
                                <b>Error:</b> ${photoError}<br/>
                            </c:forEach>
                            <c:forEach var="photoWarning" items="${photoStatus.warnings}">
                                <b>Warning:</b> ${photoWarning}<br/>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                </div>
            </c:if>
            
            
        
            <div>
                <div class="text-align-right">
                    <p class="checkout-subtotal">prints: ${order.printPriceString}</p>
                    <p class="checkout-subtotal">shipping: ${order.shippingPriceString}</p>
                    <p class="checkout-total">Total: ${order.totalPriceString}</p>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${not empty it.loginUrl}">
            <p>This page is for admins only. <a href="${it.loginUrl}" data-ajax="false">login</a></p>
        </c:if>
        <c:if test="${not empty it.logoutUrl}">
            <p><a href="${it.logoutUrl}" data-ajax="false">logout</a></p>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/jsp/parts/page-footer.jsp" />

</div>

<script type="text/javascript">
    $(document).ready(function() {    
        $( "#order-state-choice-id" ).bind( "change", function(event, ui) {
            window.location.href = "/orders/" + $("#order-state-choice-id").val();
        });
    });
</script>

</body>
</html>