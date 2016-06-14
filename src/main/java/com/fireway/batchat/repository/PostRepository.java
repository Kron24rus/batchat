package com.fireway.batchat.repository;

import com.fireway.batchat.entity.Post;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by kron on 13.06.16.
 */
@Repository
public interface PostRepository extends CrudRepository<Post, Long> {
    public Post findByPostName(String postName);
}
