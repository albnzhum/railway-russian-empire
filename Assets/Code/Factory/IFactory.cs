namespace Railway.Factory
{
    public interface IFactory<T>
    {
        T Create();
    }
}