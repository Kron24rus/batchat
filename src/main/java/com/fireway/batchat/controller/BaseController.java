package com.fireway.batchat.controller;

import com.fireway.batchat.entity.Role;
import com.fireway.batchat.entity.User;
import com.fireway.batchat.repository.RoleRepository;
import com.fireway.batchat.repository.UserInfoRepository;
import com.fireway.batchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kron on 12.06.16.
 */
@Controller
public class BaseController {

    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    UserInfoRepository userInfoRepository;

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

    @RequestMapping(value = "/createuser", method = RequestMethod.GET)
    public ModelAndView createUserPage() {
        ModelAndView model = new ModelAndView();
        model.addObject("buttonaction", "Create");
        model.addObject("actiononuser", "Create user");
        model.setViewName("createuser");
        return model;
    }


    @RequestMapping(value = "/modcurrentuser", method = RequestMethod.GET)
    public ModelAndView modifyUserPage(@RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        model.addObject("buttonaction", "Modify");
        model.addObject("actiononuser", "Modify user " + username);
        model.setViewName("createuser");
        return model;
    }

    @RequestMapping(value = "/modifyuser", method = RequestMethod.GET)
    public ModelAndView allUsersPage() {
        List<User> users = (List<User>) userRepository.findAll();
        ModelAndView model = new ModelAndView();
        model.addObject("userlist", users);
        model.setViewName("/modifyuser");
        return model;
    }

    @RequestMapping(value = "/adduser", method = RequestMethod.POST)
    public ModelAndView addUser() {
        return null;
    }

    @RequestMapping(value = "/deleteuser", method = RequestMethod.GET)
    public ModelAndView deleteUser(@RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        Long userId = userRepository.findByUserName(username).getUserId();
        userRepository.delete(userId);
        userInfoRepository.delete(userId);
        List<User> users = (List<User>) userRepository.findAll();
        model.addObject("userlist", users);
        model.setViewName("/modifyuser");
        return model;
    }

    @RequestMapping(value = "/userinfo", method = RequestMethod.GET)
    public ModelAndView userInfoPage(@RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        User user = userRepository.findUserInfoByUserName(username);
        model.addObject("firstname", user.getUserInfo().getFirstName());
        model.addObject("secondname", user.getUserInfo().getSecondName());
        model.addObject("userpost", user.getUserInfo().getPost().getPostName());
        model.setViewName("userinfo");
        return model;
    }
}
