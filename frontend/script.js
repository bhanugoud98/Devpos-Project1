const API_URL = 'http://localhost:5000/tasks';

async function fetchTasks() {
    const response = await fetch(API_URL);
    const data = await response.json();
    const list = document.getElementById('taskList');
    list.innerHTML = '';
    data.tasks.forEach(task => {
        const li = document.createElement('li');
        li.className = task.done ? 'done' : '';
        li.innerHTML = `
            <span onclick="toggleTask(${task.id}, ${!task.done})">${task.title}</span>
            <button class="delete-btn" onclick="deleteTask(${task.id})">Delete</button>
        `;
        list.appendChild(li);
    });
}

async function addTask() {
    const input = document.getElementById('taskInput');
    const title = input.value;
    if (!title) return;

    await fetch(API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title })
    });
    input.value = '';
    fetchTasks();
}

async function toggleTask(id, done) {
    await fetch(`${API_URL}/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ done })
    });
    fetchTasks();
}

async function deleteTask(id) {
    await fetch(`${API_URL}/${id}`, {
        method: 'DELETE'
    });
    fetchTasks();
}

fetchTasks();
