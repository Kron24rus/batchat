package com.fireway.batchat.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by kron on 12.06.16.
 */
@Controller
public class BaseController {

    @RequestMapping(value = {"/", "/login**"}, method = {RequestMethod.GET})
    public ModelAndView loginPage() {
        ModelAndView model = new ModelAndView();
        model.setViewName("login");
        return model;
    }

    @RequestMapping(value = "/roomlist", method = RequestMethod.GET)
    public ModelAndView allRoomPage() {
        ModelAndView model = new ModelAndView();
        model.addObject("rooms", "All rooms");
        model.setViewName("roomlist");
        return model;
    }

    @RequestMapping(value = "/myroomlist", method = RequestMethod.GET)
    public ModelAndView userRoomPage() {
        ModelAndView model = new ModelAndView();
        model.addObject("rooms", "My rooms");
        model.setViewName("roomlist");
        return model;
    }
}
