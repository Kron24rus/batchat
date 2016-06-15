package com.fireway.batchat.entity;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author Alexander Mikheev
 */
@Entity
@Table(name = "user_info")
public class UserInfo implements Serializable {

    @Id
    @Column(name = "user_id")
    @GeneratedValue(generator = "customGenerator")
    @GenericGenerator(name = "customGenerator", strategy = "foreign",
        parameters = @Parameter(name = "property", value = "user"))
    private long userId;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "second_name")
    private String secondName;

    @OneToOne
    @PrimaryKeyJoinColumn
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "post_id")
    private Post post;

    public UserInfo() {
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    @Override
    public String toString() {
        return "UserInfo{" +
                ", firstName='" + firstName + '\'' +
                ", secondName='" + secondName + '\'' +
                ", user=" + user.getUserName() +
                ", post=" + post.getPostName() +
                '}';
    }
}
