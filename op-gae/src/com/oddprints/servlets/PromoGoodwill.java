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
package com.oddprints.servlets;

import java.net.URISyntaxException;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import com.google.common.collect.Maps;
import com.oddprints.PMF;
import com.oddprints.dao.Basket;
import com.sun.jersey.api.view.Viewable;

@Path("/goodwill")
public class PromoGoodwill {

    @GET
    @Produces(MediaType.TEXT_HTML)
    @Path("sandrine482")
    public Viewable pfb(@Context HttpServletRequest req)
            throws URISyntaxException {
        return get(req, "Sandrine", 15);
    }

    public Viewable get(HttpServletRequest req, String name, int discount)
            throws URISyntaxException {

        PersistenceManager pm = PMF.get().getPersistenceManager();
        Basket basket = Basket.getOrCreateBasket(req, pm);

        basket.setDiscountPercentage(discount);
        basket.setDiscountText(name + " discount");

        pm.makePersistent(basket);
        pm.close();

        Map<String, Object> it = Maps.newHashMap();
        it.put("name", name);
        it.put("discount", discount);

        return new Viewable("/promo-goodwill", it);
    }
}
