<template>
    <blockquote class="blockquote blockquote-custom bg-white p-5 shadow rounded ">
        <div class="blockquote-custom-icon bg-dark shadow-sm">
            <h1>
                <i class="fa fa-quote-left text-white">
                    Our Blog posts of all users
                </i>
            </h1>
        </div>
        <ul class="list-group list-group-flush">
            <li class="list-group-item" v-for=" post in posts " :key="post.id">
                    <a v-bind:href="'/post/'+ post.id">
                    {{ post.title }}
                </a>
                <br/>
                {{post.short_content}}
            </li>
        </ul>
        <nav aria-label="Page navigation example">
            <div class="text-center mt-4">
                <ul class="pagination" style="display: inline-flex">
                    <li :class="[{disabled: !pagination.prev_page_url}]"><a class="page-link " href="#"
                    @click="fetchPosts(pagination.prev_page_url)">Previous</a></li>

                    <li class="page-item disabled"><a class="page-link text-dark" href="#">Page: {{ pagination.current_page }} of {{ pagination.last_page}}</a></li>

                    <li class="disabled"><a class="page-link" href="#"
                    @click="fetchPosts(pagination.next_page_url)">Next</a></li>
                </ul>
            </div>
        </nav>
    </blockquote>
</template>

<script>
    export default {
        data() {
            return {
                posts: [],
                post: {
                    id: '',
                    title: '',
                    short_content: '',
                    content: '',
                    user_id: '',
                    created_at: '',
                    updated_at: '',
                    deleted_at: ''
                },
                pagination: {},

            }
        },
        created() {
            this.fetchPosts();
        },
        methods: {
            fetchPosts(page_url) {
                let vm = this;
                page_url = page_url || 'api/posts'
                console.log(page_url)
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                              console.log(res)

                        this.posts = res.data;
                        vm.makePagination(res.current_page,res.last_page, res.next_page_url, res.prev_page_url);
                    })
                .catch(err => console.log(err));

            },
            makePagination(current_page, last_page, next_page_url, prev_page_url) {
                 this.pagination = {
                    current_page: current_page,
                    last_page: last_page,
                    next_page_url: next_page_url,
                    prev_page_url: prev_page_url
                };
                      console.log(this.pagination);

            },
        }
    }
</script>
