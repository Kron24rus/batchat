package com.fireway.batchat.controller;

import com.fireway.batchat.entity.User;
import com.fireway.batchat.repository.RoleRepository;
import com.fireway.batchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by kron on 12.06.16.
 */
@Controller
public class BaseController {

    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserRepository userRepository;

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

    @RequestMapping(value = "/userinfo", method = RequestMethod.GET)
    public ModelAndView userInfoPage(@RequestParam("username") String username) {
        ModelAndView model = new ModelAndView();
        User user = userRepository.findUserInfoByUserName(username);
        model.addObject("firstname", user.getUserInfo().getFirstName());
        model.addObject("secondname", user.getUserInfo().getSecondName());
        model.addObject("userpost", user.getUserInfo().getPost().getPostName());
        model.setViewName("userinfo");
        return model;
    }
}
