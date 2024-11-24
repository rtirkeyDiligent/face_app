import React, { useState } from 'react';

const UploadForm = () => {
  const [title, setTitle] = useState('');
  const [file, setFile] = useState(null);
  const [uploads, setUploads] = useState([]);

  const fetchUploads = async () => {
    const response = await fetch('/uploads');
    const data = await response.json();
    setUploads(data);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('upload[title]', title);
    formData.append('upload[image]', file);

    const response = await fetch('/uploads', {
      method: 'POST',
      body: formData,
    });

    if (response.ok) {
      fetchUploads();
    }
  };

  return (
    <div>
      <h1>Face App</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
        />
        <input type="file" onChange={(e) => setFile(e.target.files[0])} />
        <button type="submit">Upload</button>
      </form>

      <h2>Uploads</h2>
      <ul>
        {uploads.map((upload) => (
          <li key={upload.id}>
            <h3>{upload.title}</h3>
            <img src={upload.image_url} alt={upload.title} />
            <p>Processed: {upload.processed ? 'Yes' : 'No'}</p>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default UploadForm;