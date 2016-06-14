package com.fireway.batchat.controller;

import com.fireway.batchat.entity.*;
import com.fireway.batchat.entity.dto.UserDTO;
import com.fireway.batchat.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.LinkedList;
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
    @Autowired
    PostRepository postRepository;
    @Autowired
    RoomRepository roomRepository;

    @RequestMapping(value = {"/", "/login**"}, method = {RequestMethod.GET})
    public ModelAndView loginPage() {
        ModelAndView model = new ModelAndView();
        model.setViewName("login");
        return model;
    }

    @RequestMapping(value = "/roomlist", method = RequestMethod.GET)
    public ModelAndView allRoomPage() {
        ModelAndView model = new ModelAndView();
        List<Room> rooms = (List<Room>)roomRepository.findAll();
        model.addObject("roomlist", rooms);
        model.addObject("rooms", "All rooms");
        model.setViewName("roomlist");
        return model;
    }

    @RequestMapping(value = "/myroomlist", method = RequestMethod.GET)
    public ModelAndView userRoomPage() {
        ModelAndView model = new ModelAndView();
        List<Room> rooms = (List<Room>)roomRepository.findAll();
        model.addObject("roomlist", rooms);
        model.addObject("rooms", "My rooms");
        model.setViewName("roomlist");
        return model;
    }

    @RequestMapping(value = "/createuser", method = RequestMethod.GET)
    public ModelAndView createUserPage() {
        List<Post> posts = (List<Post>)postRepository.findAll();
        List<String> postNames = new ArrayList<String>();
        for (Post p : posts) {
            postNames.add(p.getPostName());
        }
        UserDTO userForm = new UserDTO();
        ModelAndView model = new ModelAndView();
        model.addObject("postList", postNames);
        model.addObject("userForm", userForm);
        model.addObject("formaction", "adduser");
        model.addObject("buttonaction", "Create");
        model.addObject("actiononuser", "Create user");
        model.setViewName("createuser");
        return model;
    }


    @RequestMapping(value = "/modcurrentuser", method = RequestMethod.GET)
    public ModelAndView modifyUserPage(@RequestParam(value = "username") String username) {
        List<Post> posts = (List<Post>)postRepository.findAll();
        List<String> postNames = new ArrayList<String>();
        for (Post p : posts) {
            postNames.add(p.getPostName());
        }
        UserDTO userForm = new UserDTO();
        User user = userRepository.findByUserName(username);
        UserInfo userInfo = userInfoRepository.findOne(user.getUserId());
        boolean isAdmin = false;
        List<Role> roles = user.getRoles();
        for (Role r : roles) {
            if (r.getRole().equals("ROLE_ADMIN")) isAdmin = true;
        }
        Post post = userInfo.getPost();
        userForm.setUserName(user.getUserName());
        userForm.setFirstName(userInfo.getFirstName());
        userForm.setSecondName(userInfo.getSecondName());
        userForm.setPostName(post.getPostName());
        userForm.setRole((isAdmin));
        ModelAndView model = new ModelAndView();
        model.addObject("postList", postNames);
        model.addObject("userForm", userForm);
        model.addObject("formaction", "updateuser");
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
    public ModelAndView addUser(@ModelAttribute("userForm") UserDTO userDto) {
        ModelAndView model = new ModelAndView();
        /**
         * Setting User Entity
         */
        User user = new User();
        user.setUserName(userDto.getUserName());
        user.setEnabled(1);
        user.setPassword(new BCryptPasswordEncoder().encode(userDto.getPassword()));
        Role role;
        if (userDto.getRole()) {
            role = roleRepository.findByRole("ROLE_ADMIN");
        } else {
            role = roleRepository.findByRole("ROLE_USER");
        }
        List<Role> roles = new LinkedList<Role>();
        roles.add(role);
        user.setRoles(roles);
        userRepository.save(user);
        /**
         * Setting User info Entity
         */
        UserInfo userInfo = new UserInfo();
        userInfo.setFirstName(userDto.getFirstName());
        userInfo.setSecondName(userDto.getSecondName());
        userInfo.setPost(postRepository.findByPostName(userDto.getPostName()));
        userInfo.setUser(userRepository.findByUserName(userDto.getUserName()));

        System.out.println(user);
        System.out.println(userInfo);
        userInfoRepository.save(userInfo);

        model.setViewName("redirect:/modifyuser");
        return model;
    }

    @RequestMapping(value = "/updateuser", method = RequestMethod.POST)
    public ModelAndView updateUser(@ModelAttribute("userForm") UserDTO userDto) {
        ModelAndView model = new ModelAndView();
        /**
         * Setting User Entity
         */
        User user = new User();
        user.setUserId(userRepository.findByUserName(userDto.getUserName()).getUserId());
        user.setUserName(userDto.getUserName());
        user.setEnabled(1);
        if (null != userDto.getPassword()) {
            user.setPassword(new BCryptPasswordEncoder().encode(userDto.getPassword()));
        }
        Role role;
        if (userDto.getRole()) {
            role = roleRepository.findByRole("ROLE_ADMIN");
        } else {
            role = roleRepository.findByRole("ROLE_USER");
        }
        List<Role> roles = new LinkedList<Role>();
        roles.add(role);
        user.setRoles(roles);
        userRepository.save(user);
        /**
         * Setting User info Entity
         */
        UserInfo userInfo = new UserInfo();
        userInfo.setUserId(user.getUserId());
        userInfo.setFirstName(userDto.getFirstName());
        userInfo.setSecondName(userDto.getSecondName());
        userInfo.setPost(postRepository.findByPostName(userDto.getPostName()));
        userInfo.setUser(userRepository.findByUserName(userDto.getUserName()));
        userInfoRepository.save(userInfo);

        model.setViewName("redirect:/modifyuser");
        return model;
    }

    @RequestMapping(value = "/deleteuser", method = RequestMethod.GET)
    public ModelAndView deleteUser(@RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        Long userId = userRepository.findByUserName(username).getUserId();
        userRepository.delete(userId);
        List<User> users = (List<User>) userRepository.findAll();
        model.addObject("userlist", users);
        model.setViewName("/modifyuser");
        return model;
    }

    @RequestMapping(value = "/userinfo", method = RequestMethod.GET)
    public ModelAndView userInfoPage(@RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        User user = userRepository.findUserInfoByUserName(username);
        model.addObject("firstname", userInfoRepository.findByUserId(user.getUserId()).getFirstName());
        model.addObject("secondname", userInfoRepository.findByUserId(user.getUserId()).getSecondName());
        model.addObject("userpost", userInfoRepository.findByUserId(user.getUserId()).getPost().getPostName());
        model.setViewName("userinfo");
        return model;
    }
}
