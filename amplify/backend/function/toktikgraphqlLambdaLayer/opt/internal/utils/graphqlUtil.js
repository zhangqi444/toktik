const axios = require('axios');
const graphql = require('graphql');
const { print } = graphql;
const gql = require('graphql-tag');

/**
 * Common interface for graphql query and mutation.
 * @param {*} data 
 * @param {*} queryName 
 * @returns 
 */
const query = async (data, queryName) => {
    const graphqlData = await axios({
        url: process.env.API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT,
        method: 'post',
        headers: { 'x-api-key': process.env.API_TOKTIK_GRAPHQLAPIKEYOUTPUT },
        data
    });
    if(graphqlData.data.errors) {
        throw new Error(graphqlData.data.errors);
    }
    return graphqlData.data.data[queryName];
};

// query
const getCategoryByName = async (name) => {
    const q = {
        query: print(gql`
            query getCategoryByName($name: String) {
                getCategoryByName(name: $name) {
                    items { id }
                }
            }
        `),
        variables: { name }
    };
    return await query(q, "getCategoryByName");
}

const getTagByName = async (name) => {
    const q = {
        query: print(gql`
            query getTagByName($name: String) {
                getTagByName(name: $name) {
                    items { id }
                }
            }
        `),
        variables: { name }
    };
    return await query(q, "getTagByName");
}

const getUserByUsername = async (username) => {
    const q = {
        query: print(gql`
            query getUserByUsername($username: String) {
                getUserByUsername(username: $username) {
                    items { id }
                }
            }
        `),
        variables: { username }
    };
    return await query(q, "getUserByUsername");
}

// mutation

const createCategory = async (input) => {
    const data = {
        query: print(gql`
            mutation createCategory($input: CreateCategoryInput!) {
                createCategory(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createCategory");
}

const createTag = async (input) => {
    const data = {
        query: print(gql`
            mutation createTag($input: CreateTagInput!) {
                createTag(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createTag");
}

const createUser = async (input) => {
    const data = {
        query: print(gql`
            mutation createUser($input: CreateUserInput!) {
                createUser(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createUser");
}

const createPost = async (input) => {
    const data = {
        query: print(gql`
            mutation createPost($input: createPostInput!) {
                createPost(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createPost");
}

module.exports = {
    query,

    getUserByUsername,
    getCategoryByName,
    getTagByName,

    createPost,
    createUser,
    createTag,
    createCategory,
};