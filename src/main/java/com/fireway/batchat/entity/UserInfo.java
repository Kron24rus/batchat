package com.fireway.batchat.entity;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;

/**
 * Created by kron on 13.06.16.
 */
@Entity
@Table(name = "user_info")
public class UserInfo {

    @Id
    @GeneratedValue(generator = "customForeignGenerator")
    @GenericGenerator(name = "customForeignGenerator", strategy = "foreign",
            parameters = @Parameter(name = "property", value = "users"))
    @Column(name = "user_id", unique = true, nullable = false)
    private Long userId;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "second_name")
    private String secondName;

    @OneToOne(fetch = FetchType.EAGER, mappedBy = "userInfo")
    @PrimaryKeyJoinColumn
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "post_id")
    private Post post;

    public UserInfo() {
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

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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
}
