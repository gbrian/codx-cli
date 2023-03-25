curl https://raw.githubusercontent.com/gbrian/codx-cli/main/python.sh | bash
pip install jupyterlab

rm .jupyter/jupyter_notebook_config.py || true

# Fix config
$HOME/.local/bin/jupyter notebook --generate-config
sed -i "s/\# c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/" .jupyter/jupyter_notebook_config.py
sed -i "s/\# c.NotebookApp.token = '<generated>'/c.NotebookApp.token = ''/" .jupyter/jupyter_notebook_config.py
sed -i "s/\# c.NotebookApp.allow_origin = ''/c.NotebookApp.allow_origin = '*'/" .jupyter/jupyter_notebook_config.py
# Register service
curl https://raw.githubusercontent.com/gbrian/codx-cli/main/register-app.sh | sudo bash -s -- "jupyter-lab" "$HOME/.local/bin/jupyter-lab"

