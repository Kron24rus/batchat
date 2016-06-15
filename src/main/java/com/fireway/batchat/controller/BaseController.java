package com.fireway.batchat.controller;

import com.fireway.batchat.entity.*;
import com.fireway.batchat.entity.dto.RoomDTO;
import com.fireway.batchat.entity.dto.UserDTO;
import com.fireway.batchat.repository.*;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
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
 * @author Alexander Mikheev
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

    @RequestMapping(value = "/createroom", method = RequestMethod.GET)
    public ModelAndView createRoomPage() {
        List<User> users = (List<User>) userRepository.findAll();
        RoomDTO roomForm = new RoomDTO();
        ModelAndView model = new ModelAndView();
        model.addObject("formaction", "/addroom");
        model.addObject("roomForm", roomForm);
        model.addObject("userList", users);
        model.addObject("roomaction", "Create");
        model.setViewName("/createroom");
        return model;
    }

    @RequestMapping(value = "/modifyroom", method = RequestMethod.GET)
    public ModelAndView updateRoomPage(@RequestParam(name = "roomname") String roomname) {
        Room room = roomRepository.findByRoomName(roomname);
        RoomDTO roomForm = new RoomDTO();
        roomForm.setRoomName(roomname);
        roomForm.setAccess(room.isPrivate());
        roomForm.setUserName(room.getUser().getUserName());
        List<Long> userId = new LinkedList<>();
        for (User u : room.getUsers()) {
            userId.add(u.getUserId());
        }
        roomForm.setPrivateUsers(userId);
        List<User> users = (List<User>) userRepository.findAll();
        ModelAndView model = new ModelAndView();
        model.addObject("userList", users);
        model.addObject("roomForm", roomForm);
        model.addObject("roomaction", "Update");
        model.addObject("formaction", "/updateroom");
        model.setViewName("/createroom");
        return model;
    }

    @RequestMapping(value = "/addroom", method = RequestMethod.POST)
    public ModelAndView addRoom(@ModelAttribute("roomForm") RoomDTO roomDto) {
        ModelAndView model = new ModelAndView();
        Room room = new Room();
        room.setPrivate(roomDto.isAccess());
        room.setRoomName(roomDto.getRoomName());
        room.setUser(userRepository.findByUserName(roomDto.getUserName()));
        if (room.isPrivate()) {
            List<User> privateUsers = new LinkedList<User>();
            for (Long id : roomDto.getPrivateUsers()) {
                privateUsers.add(userRepository.findByUserId(id));
                System.out.println(userRepository.findByUserId(id).getUserName());
            }
            room.setUsers(privateUsers);
        }
        roomRepository.save(room);
        System.out.println(roomDto);
        model.setViewName("redirect:/roomlist");
        return model;
    }

    @RequestMapping(value = "/updateroom", method = RequestMethod.POST)
    public ModelAndView updateRoom(@ModelAttribute("roomForm") RoomDTO roomDto) {
        Room room = new Room();
        room.setRoomName(roomDto.getRoomName());
        room.setPrivate(roomDto.isAccess());
        room.setRoomId(roomRepository.findByRoomName(roomDto.getRoomName()).getRoomId());
        room.setUser(userRepository.findByUserName(roomDto.getUserName()));
        if (null != roomDto.getPrivateUsers()) {
            List<User> users = new LinkedList<>();
            for (Long l : roomDto.getPrivateUsers()) {
                users.add(userRepository.findByUserId(l));
            }
            room.setUsers(users);
        }
        roomRepository.save(room);
        ModelAndView model = new ModelAndView();
        model.setViewName("redirect:/roomlist");
        return model;
    }

    @RequestMapping(value = "/deleteroom", method = RequestMethod.GET)
    public ModelAndView deleteRoom(@RequestParam(value = "roomname") String roomname) {
        ModelAndView model = new ModelAndView();
        Long roomId = roomRepository.findByRoomName(roomname).getRoomId();
        roomRepository.delete(roomId);
        List<Room> rooms = (List<Room>)roomRepository.findAll();
        model.addObject("roomlist", rooms);
        model.setViewName("redirect:/roomlist");
        return model;
    }

    @RequestMapping(value = "/roomchat", method = RequestMethod.GET)
    public ModelAndView chatPage(@RequestParam(value = "roomname") String roomname,
                                 @RequestParam(value = "username") String username) {
        ModelAndView model = new ModelAndView();
        Room room = roomRepository.findByRoomName(roomname);
        if (room.isPrivate()) {
            List<User> users = room.getUsers();
            boolean isParticipant = false;
            for (User u : users) {
                if (u.getUserName().equals(username)) isParticipant = true;
            }
            if (room.getUser().getUserName().equals(username)) isParticipant = true;
            if (isParticipant) {
                model.addObject("roomname", roomname);
                model.setViewName("roomchat");
                return model;
            } else {
                model.setViewName("redirect:/roomlist");
                return model;
            }
        } else {
            model.addObject("roomname", roomname);
            model.setViewName("roomchat");
            return model;
        }
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
        if (userDto.getPassword().length() > 0) {
            user.setPassword(new BCryptPasswordEncoder().encode(userDto.getPassword()));
        } else {
            user.setPassword(userRepository.findByUserName(userDto.getUserName()).getPassword());
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
        List<User> users = (List<User>) userRepository.findAll();
        try {
            userRepository.delete(userId);
        } catch (Exception e) {
            model.addObject("userlist", users);
            model.setViewName("/modifyuser");
            return model;
        }
        model.addObject("userlist", users);
        model.setViewName("redirect:/modifyuser");
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
