/*******************************************************************************
 * Copyright 2011 Matt Burns
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package com.oddprints.checkout;

import java.util.Map;

import com.oddprints.dao.Basket.CheckoutSystem;

public class PaypalCheckoutNotificationHandler {
    private CheckoutNotificationHandler checkoutNotificationHandler;

    public PaypalCheckoutNotificationHandler(
            CheckoutNotificationHandler checkoutNotificationHandler) {
        this.checkoutNotificationHandler = checkoutNotificationHandler;
    }

    public void onAuthorizationAmountNotification(
            Map<String, String> parameterMap) {
        String checkoutSystemOrderNumber = parameterMap.get("txn_id");
        String basketKeyString = parameterMap.get("custom");
        String buyerEmail = parameterMap.get("payer_email");

        Address address = extractAddress(parameterMap);

        checkoutNotificationHandler.onAuthorizationAmountNotification(
                CheckoutSystem.paypal, checkoutSystemOrderNumber,
                basketKeyString, buyerEmail, address);
    }

    public void onNewOrderNotification(Map<String, String> parameterMap) {
        String checkoutSystemOrderNumber = parameterMap.get("txn_id");
        String basketKeyString = parameterMap.get("custom");
        String buyerEmail = parameterMap.get("payer_email");

        checkoutNotificationHandler.onNewOrderNotification(
                CheckoutSystem.paypal, checkoutSystemOrderNumber,
                basketKeyString, buyerEmail);
    };

    private Address extractAddress(Map<String, String> parameterMap) {
        Address address = new Address();

        address.setRecipientName(parameterMap.get("address_name"));
        address.setAddress1(parameterMap.get("address_street"));
        address.setTownOrCity(parameterMap.get("address_city"));
        address.setStateOrCounty(parameterMap.get("address_state"));
        address.setPostalOrZipCode(parameterMap.get("address_zip"));
        address.setCountry(parameterMap.get("address_country"));
        return address;
    }
}
